#include <stdlib.h>
#include <string.h>

#define MAX_N 100005

long long N_ROWS_GLOBAL; // Number of rows
long long M_VAL_GLOBAL;  // Seats per row

typedef struct {
    long long min_val;      // Minimum occupied seats in the range
    long long max_val;      // Maximum occupied seats in the range
    long long sum_val;      // Sum of occupied seats in the range
    long long lazy_add;     // Lazy tag for range additions
    long long lazy_set;     // Lazy tag for range assignments (e.g., filling rows to M_VAL)
    int is_lazy_set;        // Flag to indicate if lazy_set is active
} SegmentTreeNode;

SegmentTreeNode tree[4 * MAX_N];

long long min(long long a, long long b) {
    return a < b ? a : b;
}

long long max(long long a, long long b) {
    return a > b ? a : b;
}

void build(int node, int start, int end) {
    tree[node].lazy_add = 0;
    tree[node].is_lazy_set = 0; // false
    if (start == end) {
        tree[node].min_val = 0;
        tree[node].max_val = 0;
        tree[node].sum_val = 0;
    } else {
        int mid = start + (end - start) / 2;
        build(2 * node, start, mid);
        build(2 * node + 1, mid + 1, end);
        tree[node].min_val = 0;
        tree[node].max_val = 0;
        tree[node].sum_val = 0;
    }
}

void push_down(int node, int start, int end) {
    if (start == end) return; // Leaf node, no children to push to

    int mid = start + (end - start) / 2;

    // Process lazy_set first, as it takes precedence
    if (tree[node].is_lazy_set) {
        long long val = tree[node].lazy_set;

        // Apply to left child
        tree[2 * node].lazy_set = val;
        tree[2 * node].is_lazy_set = 1; // true
        tree[2 * node].lazy_add = 0; // Clear any pending add
        tree[2 * node].min_val = val;
        tree[2 * node].max_val = val;
        tree[2 * node].sum_val = val * (mid - start + 1);

        // Apply to right child
        tree[2 * node + 1].lazy_set = val;
        tree[2 * node + 1].is_lazy_set = 1; // true
        tree[2 * node + 1].lazy_add = 0; // Clear any pending add
        tree[2 * node + 1].min_val = val;
        tree[2 * node + 1].max_val = val;
        tree[2 * node + 1].sum_val = val * (end - mid);

        tree[node].is_lazy_set = 0; // false
    }

    // Process lazy_add
    if (tree[node].lazy_add != 0) {
        long long val = tree[node].lazy_add;

        // Apply to left child
        if (tree[2 * node].is_lazy_set) { // If child has a lazy_set, apply add to that set value
            tree[2 * node].lazy_set += val;
            tree[2 * node].min_val = tree[2 * node].lazy_set;
            tree[2 * node].max_val = tree[2 * node].lazy_set;
            tree[2 * node].sum_val = tree[2 * node].lazy_set * (mid - start + 1);
        } else { // Otherwise, apply to existing values
            tree[2 * node].min_val += val;
            tree[2 * node].max_val += val;
            tree[2 * node].sum_val += val * (mid - start + 1);
            tree[2 * node].lazy_add += val;
        }

        // Apply to right child
        if (tree[2 * node + 1].is_lazy_set) {
            tree[2 * node + 1].lazy_set += val;
            tree[2 * node + 1].min_val = tree[2 * node + 1].lazy_set;
            tree[2 * node + 1].max_val = tree[2 * node + 1].lazy_set;
            tree[2 * node + 1].sum_val = tree[2 * node + 1].lazy_set * (end - mid);
        } else {
            tree[2 * node + 1].min_val += val;
            tree[2 * node + 1].max_val += val;
            tree[2 * node + 1].sum_val += val * (end - mid);
            tree[2 * node + 1].lazy_add += val;
        }

        tree[node].lazy_add = 0;
    }
}

void update_range_add(int node, int start, int end, int query_low, int query_high, long long val_to_add) {
    if (start > query_high || end < query_low) {
        return;
    }
    if (query_low <= start && end <= query_high) {
        // Apply lazy_add
        if (tree[node].is_lazy_set) {
            tree[node].lazy_set += val_to_add;
            tree[node].min_val = tree[node].lazy_set;
            tree[node].max_val = tree[node].lazy_set;
            tree[node].sum_val = tree[node].lazy_set * (end - start + 1);
        } else {
            tree[node].min_val += val_to_add;
            tree[node].max_val += val_to_add;
            tree[node].sum_val += val_to_add * (end - start + 1);
            tree[node].lazy_add += val_to_add;
        }
        return;
    }

    push_down(node, start, end);
    int mid = start + (end - start) / 2;
    update_range_add(2 * node, start, mid, query_low, query_high, val_to_add);
    update_range_add(2 * node + 1, mid + 1, end, query_low, query_high, val_to_add);

    tree[node].min_val = min(tree[2 * node].min_val, tree[2 * node + 1].min_val);
    tree[node].max_val = max(tree[2 * node].max_val, tree[2 * node + 1].max_val);
    tree[node].sum_val = tree[2 * node].sum_val + tree[2 * node + 1].sum_val;
}

void update_range_set(int node, int start, int end, int query_low, int query_high, long long val_to_set) {
    if (start > query_high || end < query_low) {
        return;
    }
    if (query_low <= start && end <= query_high) {
        tree[node].min_val = val_to_set;
        tree[node].max_val = val_to_set;
        tree[node].sum_val = val_to_set * (end - start + 1);
        tree[node].lazy_set = val_to_set;
        tree[node].is_lazy_set = 1; // true
        tree[node].lazy_add = 0; // Clear any pending add
        return;
    }

    push_down(node, start, end);
    int mid = start + (end - start) / 2;
    update_range_set(2 * node, start, mid, query_low, query_high, val_to_set);
    update_range_set(2 * node + 1, mid + 1, end, query_low, query_high, val_to_set);

    tree[node].min_val = min(tree[2 * node].min_val, tree[2 * node + 1].min_val);
    tree[node].max_val = max(tree[2 * node].max_val, tree[2 * node + 1].max_val);
    tree[node].sum_val = tree[2 * node].sum_val + tree[2 * node + 1].sum_val;
}

int query_find_row_for_book(int node, int start, int end, long long target_occupied_val) {
    if (tree[node].min_val > target_occupied_val) {
        return -1; // No row in this segment satisfies the condition
    }
    if (start == end) {
        return start; // Found the row
    }

    push_down(node, start, end);
    int mid = start + (end - start) / 2;
    int res = query_find_row_for_book(2 * node, start, mid, target_occupied_val);
    if (res != -1) {
        return res;
    }
    return query_find_row_for_book(2 * node + 1, mid + 1, end, target_occupied_val);
}

long long query_occupied_at_leaf(int node, int start, int end, int idx) {
    if (start == end) {
        return tree[node].min_val;
    }

    push_down(node, start, end);
    int mid = start + (end - start) / 2;
    if (idx <= mid) {
        return query_occupied_at_leaf(2 * node, start, mid, idx);
    } else {
        return query_occupied_at_leaf(2 * node + 1, mid + 1, end, idx);
    }
}

int query_find_first_non_full_row(int node, int start, int end, int query_low, int query_high) {
    if (start > query_high || end < query_low || tree[node].min_val == M_VAL_GLOBAL) {
        return -1; // Range outside query, or all rows in segment are full
    }
    if (start == end) {
        return start; // Found the row
    }

    push_down(node, start, end);
    int mid = start + (end - start) / 2;
    int res = -1;
    // Search left child if its range overlaps and it might contain a non-full row
    if (query_low <= mid && tree[2 * node].min_val < M_VAL_GLOBAL) {
        res = query_find_first_non_full_row(2 * node, start, mid, query_low, query_high);
    }
    if (res != -1) {
        return res;
    }
    // Search right child if its range overlaps and it might contain a non-full row
    if (query_high > mid && tree[2 * node + 1].min_val < M_VAL_GLOBAL) {
        res = query_find_first_non_full_row(2 * node + 1, mid + 1, end, query_low, query_high);
    }
    return res;
}

long long query_sum_occupied_in_range(int node, int start, int end, int query_low, int query_high) {
    if (start > query_high || end < query_low) {
        return 0;
    }
    if (query_low <= start && end <= query_high) {
        return tree[node].sum_val;
    }

    push_down(node, start, end);
    int mid = start + (end - start) / 2;
    long long sum = 0;
    sum += query_sum_occupied_in_range(2 * node, start, mid, query_low, query_high);
    sum += query_sum_occupied_in_range(2 * node + 1, mid + 1, end, query_low, query_high);
    return sum;
}

long long query_sum_capped(int node, int start, int end, int query_low, int query_high, long long C_cap) {
    if (start > query_high || end < query_low) {
        return 0;
    }
    if (query_low <= start && end <= query_high) {
        if (tree[node].max_val <= C_cap) { // All values in segment are <= C_cap
            return tree[node].sum_val;
        }
        if (tree[node].min_val >= C_cap) { // All values in segment are >= C_cap
            return (long long)(end - start + 1) * C_cap;
        }
    }

    push_down(node, start, end);
    int mid = start + (end - start) / 2;
    long long sum = 0;
    sum += query_sum_capped(2 * node, start, mid, query_low, query_high, C_cap);
    sum += query_sum_capped(2 * node + 1, mid + 1, end, query_low, query_high, C_cap);
    return sum;
}

int find_end_row_for_scatter(int node, int start, int end, int query_low, int query_high, long long k_needed) {
    if (start > query_high || end < query_low) {
        return query_low - 1; // Out of range, return a value indicating no row found
    }
    // If all rows in this segment are full, no tickets can be placed here
    if (tree[node].min_val == M_VAL_GLOBAL) {
        return query_low - 1;
    }

    // If it's a leaf node
    if (start == end) {
        long long available_in_row = M_VAL_GLOBAL - tree[node].min_val;
        if (available_in_row > 0 && k_needed > 0) {
            return start; // This row can take tickets
        } else {
            return start - 1; // This row cannot take tickets (full or k_needed is 0)
        }
    }

    push_down(node, start, end);
    int mid = start + (end - start) / 2;

    // Calculate available seats in the left child's relevant range
    int left_child_clip_low = max(start, query_low);
    int left_child_clip_high = min(mid, query_high);
    long long available_in_left_range = 0;
    if (left_child_clip_low <= left_child_clip_high) {
        available_in_left_range = (long long)(left_child_clip_high - left_child_clip_low + 1) * M_VAL_GLOBAL - 
                                  query_sum_occupied_in_range(2 * node, start, mid, left_child_clip_low, left_child_clip_high);
    }

    // If the left child's range can accommodate all remaining tickets, search there
    if (available_in_left_range >= k_needed) {
        return find_end_row_for_scatter(2 * node, start, mid, query_low, query_high, k_needed);
    } else {
        // Otherwise, try to find in the right child, subtracting seats filled in left
        int res = find_end_row_for_scatter(2 * node + 1, mid + 1, end, query_low, query_high, k_needed - available_in_left_range);
        if (res != query_low - 1) { // If a row was found in the right child
            return res;
        } else { // If nothing found in right child, it means the last seat is in the left child's range
                 // The last row that could take tickets is the last row of the left child's clipped range
            return left_child_clip_high;
        }
    }
}

typedef struct {
    // No specific members needed here as segment tree is global
} ConcertTickets;

ConcertTickets* concertTicketsCreate(int n, int m) {
    ConcertTickets* obj = (ConcertTickets*)malloc(sizeof(ConcertTickets));
    N_ROWS_GLOBAL = n;
    M_VAL_GLOBAL = m;
    build(1, 0, N_ROWS_GLOBAL - 1);
    return obj;
}

long long* concertTicketsBook(ConcertTickets* obj, int k, int* retSize) {
    long long target_occupied_val = M_VAL_GLOBAL - k;
    int r_found = query_find_row_for_book(1, 0, N_ROWS_GLOBAL - 1, target_occupied_val);

    if (r_found == -1) {
        *retSize = 0;
        return NULL;
    }

    long long s_start = query_occupied_at_leaf(1, 0, N_ROWS_GLOBAL - 1, r_found);
    update_range_add(1, 0, N_ROWS_GLOBAL - 1, r_found, r_found, k);

    long long* result = (long long*)malloc(sizeof(long long) * 2);
    result[0] = r_found;
    result[1] = s_start;
    *retSize = 2;
    return result;
}

long long concertTicketsScatter(ConcertTickets* obj, int k, int maxRow) {
    long long total_booked = 0;
    long long current_k = k;

    // 1. Find the first available row in the range [0, maxRow]
    int r_start = query_find_first_non_full_row(1, 0, N_ROWS_GLOBAL - 1, 0, maxRow);

    if (r_start == -1) {
        return 0; // No available seats at all
    }

    // 2. Find the last row 'r_end' in [r_start, maxRow] that would receive tickets
    int r_end = find_end_row_for_scatter(1, 0, N_ROWS_GLOBAL - 1, r_start, maxRow, current_k);

    if (r_end < r_start) { // This implies no tickets could be placed even in r_start, which contradicts r_start != -1
        return 0; // Or some error, but for problem constraints, means no tickets can be placed.
    }

    // 3. Fill 'r_start' (partially or fully)
    long long occupied_r_start = query_occupied_at_leaf(1, 0, N_ROWS_GLOBAL - 1, r_start);
    long long seats_to_fill_in_r_start = min(current_k, M_VAL_GLOBAL - occupied_r_start);
    update_range_add(1, 0, N_ROWS_GLOBAL - 1, r_start, r_start, seats_to_fill_in_r_start);
    total_booked += seats_to_fill_in_r_start;
    current_k -= seats_to_fill_in_r_start;

    if (current_k == 0) return total_booked;

    // 4. Fill rows from 'r_start + 1' to 'r_end - 1' completely
    if (r_end > r_start) { // Only if there are rows between r_start and r_end
        long long sum_occupied_middle_rows = query_sum_occupied_in_range(1, 0, N_ROWS_GLOBAL - 1, r_start + 1, r_end - 1);
        long long num_middle_rows = (long long)(r_end - 1) - (r_start + 1) + 1;
        if (num_middle_rows < 0) num_middle_rows = 0; // Handle case where r_end == r_start + 1

        long long seats_available_in_middle_rows = num_middle_rows * M_VAL_GLOBAL - sum_occupied_middle_rows;

        long long fill_middle = min(current_k, seats_available_in_middle_rows);
        if (num_middle_rows > 0) { // Only update if range is valid
            update_range_set(1, 0, N_ROWS_GLOBAL - 1, r_start + 1, r_end - 1, M_VAL_GLOBAL); // Set these rows to full
        }
        total_booked += fill_middle;
        current_k -= fill_middle;
    }

    if (current_k == 0) return total_booked;

    // 5. Fill 'r_end' (partially), only if r_end is different from r_start
    if (r_end > r_start) { // If r_end == r_start, it was already handled in step 3
        long long occupied_r_end = query_occupied_at_leaf(1, 0, N_ROWS_GLOBAL - 1, r_end);
        long long seats_to_fill_in_r_end = min(current_k, M_VAL_GLOBAL - occupied_r_end);
        update_range_add(1, 0, N_ROWS_GLOBAL - 1, r_end, r_end, seats_to_fill_in_r_end);
        total_booked += seats_to_fill_in_r_end;
        current_k -= seats_to_fill_in_r_end;
    }

    return total_booked;
}

long long concertTicketsSum(ConcertTickets* obj, int r, int c) {
    return query_sum_capped(1, 0, N_ROWS_GLOBAL - 1, 0, r, c + 1);
}

void concertTicketsFree(ConcertTickets* obj) {
    // No dynamic memory for segment tree nodes, they are global/static
    free(obj);
}