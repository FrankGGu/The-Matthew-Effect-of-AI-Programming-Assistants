class SegTreeNode {
    constructor(L, R) {
        this.L = L;
        this.R = R;
        this.min_occupied = 0; // Minimum seats occupied in any row within [L, R]
        this.sum_occupied = 0; // Sum of seats occupied across all rows in [L, R]
        this.left = null;
        this.right = null;
    }
}

class BookMyShow {
    constructor(n, m) {
        this.n = n; // Number of rows
        this.m = m; // Seats per row
        this.seats_occupied_in_row = new Array(n).fill(0); // Actual state of seats in each row
        this.next_available_row_for_scatter = 0; // Pointer to the first row that is not fully occupied
        this.root = this.build(0, n - 1);
    }

    // Builds the segment tree
    build(L, R) {
        const node = new SegTreeNode(L, R);
        if (L === R) {
            return node;
        }
        const mid = Math.floor((L + R) / 2);
        node.left = this.build(L, mid);
        node.right = this.build(mid + 1, R);
        return node;
    }

    // Updates a specific row's occupied count in the segment tree
    update(node, target_row, new_occupied_count) {
        if (node.L === node.R) { // Leaf node
            node.min_occupied = new_occupied_count;
            node.sum_occupied = new_occupied_count;
            return;
        }

        const mid = Math.floor((node.L + node.R) / 2);
        if (target_row <= mid) {
            this.update(node.left, target_row, new_occupied_count);
        } else {
            this.update(node.right, target_row, new_occupied_count);
        }
        // Update current node after children are updated
        node.min_occupied = Math.min(node.left.min_occupied, node.right.min_occupied);
        node.sum_occupied = node.left.sum_occupied + node.right.sum_occupied;
    }

    // Finds the smallest row 'r' in [node.L, node.R] (up to query_max_row)
    // such that 'k_seats' can be booked (i.e., seats_occupied_in_row[r] <= m - k_seats)
    find_first_row_for_gather(node, k_seats, query_max_row) {
        // If current node's range is outside query_max_row or no row in this range has enough capacity
        if (node.L > query_max_row || node.min_occupied > this.m - k_seats) {
            return -1;
        }
        // If leaf node, it must be the first such row in its range
        if (node.L === node.R) {
            return node.L;
        }

        const mid = Math.floor((node.L + node.R) / 2);
        let res = -1;

        // Try left child if it's within query_max_row and might contain a solution
        if (node.left && node.left.L <= query_max_row && node.left.min_occupied <= this.m - k_seats) {
             res = this.find_first_row_for_gather(node.left, k_seats, query_max_row);
        }

        if (res !== -1) {
            return res;
        }

        // If not found in left, try right child if it's within query_max_row and might contain a solution
        if (node.right && node.right.L <= query_max_row && node.right.min_occupied <= this.m - k_seats) {
            return this.find_first_row_for_gather(node.right, k_seats, query_max_row);
        }

        return -1;
    }

    // Queries total available seats in range [query_start_row, query_end_row]
    query_sum_available(node, query_start_row, query_end_row) {
        // If current node's range is completely outside the query range
        if (node.R < query_start_row || node.L > query_end_row) {
            return 0;
        }
        // If current node's range is completely inside the query range
        if (node.L >= query_start_row && node.R <= query_end_row) {
            return (node.R - node.L + 1) * this.m - node.sum_occupied;
        }

        // Partially overlapping, recurse
        const mid = Math.floor((node.L + node.R) / 2);
        const left_available = this.query_sum_available(node.left, query_start_row, query_end_row);
        const right_available = this.query_sum_available(node.right, query_start_row, query_end_row);
        return left_available + right_available;
    }

    // Recursively fills 'k_ref.val' seats starting from 'current_fill_row_start' up to 'query_max_row'
    // This is a helper for the scatter method. 'k_ref' is an object to pass 'k' by reference.
    fill_seats_for_scatter(node, current_fill_row_start, query_max_row, k_ref) {
        // Base cases for stopping recursion
        if (k_ref.val === 0 || node.L > query_max_row || node.R < current_fill_row_start || node.min_occupied === this.m) {
            return;
        }

        // If leaf node, perform booking for this row
        if (node.L === node.R) {
            const row_idx = node.L;
            const available_in_row = this.m - this.seats_occupied_in_row[row_idx];
            const seats_to_book = Math.min(k_ref.val, available_in_row);

            this.seats_occupied_in_row[row_idx] += seats_to_book;
            k_ref.val -= seats_to_book;

            node.min_occupied = this.seats_occupied_in_row[row_idx];
            node.sum_occupied = this.seats_occupied_in_row[row_idx];
            return;
        }

        // Recurse to children
        const mid = Math.floor((node.L + node.R) / 2);

        // Only go left if there's overlap with current_fill_row_start and left child might contain available seats
        if (current_fill_row_start <= mid && node.left.min_occupied < this.m) {
            this.fill_seats_for_scatter(node.left, current_fill_row_start, query_max_row, k_ref);
        }

        // If k_ref.val is still positive, try right child if it might contain available seats
        if (k_ref.val > 0 && mid + 1 <= query_max_row && node.right.min_occupied < this.m) {
            this.fill_seats_for_scatter(node.right, current_fill_row_start, query_max_row, k_ref);
        }

        // Update current node from children after recursive calls
        node.min_occupied = Math.min(node.left.min_occupied, node.right.min_occupied);
        node.sum_occupied = node.left.sum_occupied + node.right.sum_occupied;
    }

    gather(k, maxRow) {
        const row = this.find_first_row_for_gather(this.root, k, maxRow);

        if (row === -1) {
            return [];
        }

        const col = this.seats_occupied_in_row[row];
        this.seats_occupied_in_row[row] += k;
        this.update(this.root, row, this.seats_occupied_in_row[row]);

        // If the row that was just booked is the next available for scatter and it became full,
        // advance the next_available_row_for_scatter pointer.
        if (row === this.next_available_row_for_scatter && this.seats_occupied_in_row[row] === this.m) {
            while (this.next_available_row_for_scatter < this.n && this.seats_occupied_in_row[this.next_available_row_for_scatter] === this.m) {
                this.next_available_row_for_scatter++;
            }
        }

        return [row, col];
    }

    scatter(k, maxRow) {
        // Amortized O(1) update for next_available_row_for_scatter
        while (this.next_available_row_for_scatter < this.n && this.seats_occupied_in_row[this.next_available_row_for_scatter] === this.m) {
            this.next_available_row_for_scatter++;
        }

        // If no rows are available within the specified range
        if (this.next_available_row_for_scatter > maxRow) {
            return [];
        }

        // Query total available seats from next_available_row_for_scatter up to maxRow
        const total_available = this.query_sum_available(this.root, this.next_available_row_for_scatter, maxRow);

        // If not enough seats are available
        if (total_available < k) {
            return [];
        }

        // Store the first booked seat's row and column
        const first_booked_row = this.next_available_row_for_scatter;
        const first_booked_seat = this.seats_occupied_in_row[first_booked_row];

        // Use a reference object to pass k by value and modify it in the recursive function
        const k_ref = { val: k };
        this.fill_seats_for_scatter(this.root, this.next_available_row_for_scatter, maxRow, k_ref);

        // After filling, update next_available_row_for_scatter again
        while (this.next_available_row_for_scatter < this.n && this.seats_occupied_in_row[this.next_available_row_for_scatter] === this.m) {
            this.next_available_row_for_scatter++;
        }

        return [first_booked_row, first_booked_seat];
    }
}