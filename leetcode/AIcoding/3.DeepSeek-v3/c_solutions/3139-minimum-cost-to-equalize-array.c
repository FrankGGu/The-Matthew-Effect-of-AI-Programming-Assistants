int minCostToEqualizeArray(int* nums, int numsSize, int cost1, int cost2) {
    long long mod = 1000000007;
    int max_val = 0;
    long long total = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    long long deficit = 0;
    for (int i = 0; i < numsSize; i++) {
        deficit += max_val - nums[i];
    }

    if (cost1 * 2 <= cost2 || numsSize <= 2) {
        return (deficit * cost1) % mod;
    }

    long long max_single = 0;
    for (int i = 0; i < numsSize; i++) {
        if (max_val - nums[i] > max_single) {
            max_single = max_val - nums[i];
        }
    }

    long long pairs_cost = 0;
    if (max_single * 2 <= deficit) {
        pairs_cost = (deficit / 2) * cost2;
        if (deficit % 2 == 1) {
            pairs_cost += cost1;
        }
    } else {
        pairs_cost = (deficit - max_single) * cost2 + (max_single - (deficit - max_single)) * cost1;
    }

    long long result = pairs_cost % mod;

    long long max_possible = max_val + deficit;
    for (long long target = max_val + 1; target <= max_possible; target++) {
        long long new_deficit = deficit + (target - max_val) * numsSize;
        long long new_max_single = max_single + (target - max_val);

        long long new_pairs_cost;
        if (new_max_single * 2 <= new_deficit) {
            new_pairs_cost = (new_deficit / 2) * cost2;
            if (new_deficit % 2 == 1) {
                new_pairs_cost += cost1;
            }
        } else {
            new_pairs_cost = (new_deficit - new_max_single) * cost2 + (new_max_single - (new_deficit - new_max_single)) * cost1;
        }

        if (new_pairs_cost < result) {
            result = new_pairs_cost;
        } else {
            break;
        }
    }

    return result % mod;
}