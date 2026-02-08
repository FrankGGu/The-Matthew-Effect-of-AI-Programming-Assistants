#include <limits.h> // For LLONG_MAX
#include <stdlib.h> // For abs, though not explicitly used for target differences as they are positive

#define MIN(a, b) ((a) < (b) ? (a) : (b))

#define HASH_PRIME 1009

typedef struct {
    long long key;
    long long value;
    int occupied; // 0: empty, 1: occupied
} MemoEntry;

static MemoEntry memo_table[HASH_PRIME];
static int global_x; // To avoid passing x in recursive calls

void init_memo() {
    for (int i = 0; i < HASH_PRIME; ++i) {
        memo_table[i].occupied = 0;
    }
}

long long get_memo(long long key) {
    long long hash = key % HASH_PRIME;
    if (hash < 0) hash += HASH_PRIME; // Ensure positive hash

    int original_hash = hash;
    while (memo_table[hash].occupied) {
        if (memo_table[hash].key == key) {
            return memo_table[hash].value;
        }
        hash = (hash + 1) % HASH_PRIME;
        if (hash == original_hash) break; // Full cycle, key not found
    }
    return LLONG_MAX; // Indicate not found
}

void put_memo(long long key, long long value) {
    long long hash = key % HASH_PRIME;
    if (hash < 0) hash += HASH_PRIME;

    int original_hash = hash;
    while (memo_table[hash].occupied) {
        if (memo_table[hash].key == key) { // Update existing entry
            memo_table[hash].value = value;
            return;
        }
        hash = (hash + 1) % HASH_PRIME;
        if (hash == original_hash) {
            // Table is full or cannot find empty slot.
            // For competitive programming, assume table won't overflow for the given constraints.
            return; 
        }
    }
    // Found an empty slot
    memo_table[hash].key = key;
    memo_table[hash].value = value;
    memo_table[hash].occupied = 1;
}

long long cost_val_for_k(int k) {
    if (k == 0) return (global_x == 1) ? 0 : 1;
    return k - 1;
}

long long solve(long long target) {
    if (target == 0) return 0;

    // Special handling for x=1 to prevent infinite loop and incorrect logic
    if (global_x == 1) {
        // If x=1, target can only be formed by 1+1+...+1
        // Cost of 1 is 0 (from cost_val_for_k(0) when global_x=1).
        // Each '+' operator costs 1. So target '1's need target-1 '+' operators.
        return target - 1;
    }

    if (target == 1) return cost_val_for_k(0); // For x!=1, cost_val_for_k(0) is 1 (for x/x)

    long long memoized_val = get_memo(target);
    if (memoized_val != LLONG_MAX) {
        return memoized_val;
    }

    long long res = LLONG_MAX;

    long long p_le_target = 1; // Represents x^0
    int k_le_target = 0;       // Represents power index for p_le_target

    // Find the largest power of global_x (x^k) that is less than or equal to target.
    // Loop condition `p_le_target <= target / global_x` prevents overflow for `p_le_target * global_x`.
    while (1) {
        long long next_p;
        if (p_le_target > LLONG_MAX / global_x) { // Check for overflow before multiplication
            break; 
        }
        next_p = p_le_target * global_x;
        if (next_p > target) { // next_p would exceed target
            break;
        }
        p_le_target = next_p;
        k_le_target++;
    }
    // After this loop, p_le_target is the largest power of global_x <= target.

    // Case 1: Express target as p_le_target + (target - p_le_target)
    // Cost: cost_val_for_k(k_le_target) for p_le_target
    //       + 1 for the '+' operator
    //       + solve(target - p_le_target) for the remainder
    res = MIN(res, cost_val_for_k(k_le_target) + 1 + solve(target - p_le_target));

    // Case 2: Express target as p_gt_target - (p_gt_target - target)
    // p_gt_target is the next power of x, which is p_le_target * global_x.
    // k_gt_target is k_le_target + 1.
    // We must check for overflow when calculating p_gt_target.
    if (p_le_target > LLONG_MAX / global_x) {
        // p_le_target * global_x would overflow.
        // This means p_le_target is already the maximum representable power of x.
        // So p_gt_target is effectively infinity, and this case is not valid.
    } else {
        long long p_gt_target = p_le_target * global_x;
        int k_gt_target = k_le_target + 1;
        // Cost: cost_val_for_k(k_gt_target) for p_gt_target
        //       + 1 for the '-' operator
        //       + solve(p_gt_target - target) for the difference
        res = MIN(res, cost_val_for_k(k_gt_target) + 1 + solve(p_gt_target - target));
    }

    put_memo(target, res);
    return res;
}

int leastOpsExpressTarget(int x, int target) {
    global_x = x;
    init_memo(); // Initialize the memoization table for each test case
    return (int)solve(target);
}