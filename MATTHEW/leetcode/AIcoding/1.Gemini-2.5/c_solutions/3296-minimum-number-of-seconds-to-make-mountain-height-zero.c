#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long min(long long a, long long b) {
    return a < b ? a : b;
}

bool check(long long T, int* mountains, int mountainsSize) {
    if (mountainsSize == 0) {
        return true;
    }

    // For each mountain i, calculate the minimum number of seconds it would take to reduce it to 0
    // if it were only reduced by gravity (i.e., its neighbors are always positive).
    // This value is effectively T.
    // If mountains[i] > T, it needs mountains[i] - T additional reductions.
    // These additional reductions must come from the 'chosen' operation.
    // The total number of 'chosen' operations available is T.
    // So, sum(max(0, mountains[i] - T)) <= T.
    // This is the simplified model assuming gravity always applies.

    // The actual problem is more complex because gravity depends on neighbors.
    // A mountain `i` can reduce its height by 2 if it's chosen AND its neighbors are positive.
    // It can reduce by 1 if it's chosen OR its neighbors are positive (and it's not chosen).
    // It reduces by 0 otherwise.

    // Let's rephrase: for each mountain i, what is the maximum height it can have
    // and still be cleared in T seconds?
    // Let this maximum clearable height for mountain i be `clearable_h[i]`.
    // If mountains[i] > clearable_h[i], then T is not enough.

    // A mountain `j` can be reduced by 1 (chosen) or 1 (gravity).
    // The gravity effect on `j` happens if `mountains[j] > 0` and `mountains[j-1] > 0` and `mountains[j+1] > 0`.
    // This means a mountain at index `i` can be cleared in `T` seconds if its height `mountains[i]` is
    // less than or equal to `T` (if it's always at an "edge" of positive mountains and needs to be chosen)
    // or less than or equal to `2T` (if it's always in the "interior" of positive mountains and is chosen, and gets gravity).

    // The critical observation is that if a mountain `i` has height `H_i`, and it is `k` positions away
    // from a mountain `j` that becomes 0 at time `t_j`, then mountain `i` can only benefit from gravity
    // for at most `t_j + k` seconds (roughly).
    // More precisely, the height of mountain `i` must be `<= T + (T - distance_to_zero_wave)`.
    // The `distance_to_zero_wave` is the time it takes for a 'zero' to propagate to `i`.

    // For each mountain `i`, its height `mountains[i]` must be cleared.
    // It can be cleared by `T` chosen operations (if we choose it every second).
    // It can be cleared by `T` gravity operations (if it always has positive neighbors).
    // So `mountains[i]` must be <= `T` (chosen only) or <= `2T` (chosen + gravity).

    // Let `max_possible_height[i]` be the maximum height mountain `i` can have
    // to be cleared in `T` seconds.
    // `max_possible_height[i]` is `T` if it's an isolated peak (neighbors are 0).
    // `max_possible_height[i]` is `T + (T - dist_to_nearest_zero_wave_source)` if it's near a zero.
    // `max_possible_height[i]` is `2T` if it's far from any zero.
    // This `dist_to_nearest_zero_wave_source` is effectively the time it takes for a zero to reach it.

    // Let's compute for each mountain `i`, the maximum height `h_can_clear[i]` that can be cleared
    // by time `T` if it's *not* chosen, but only relies on gravity from its neighbors.
    // `h_can_clear[i]` would be `T` if its neighbors are always positive.
    // If `mountains[i]` is `H_i`.
    // If `H_i > T`, then it needs `H_i - T` extra reductions from being chosen.
    // The total chosen operations available is `T`.

    // The correct check function for this type of problem:
    // For each mountain `i`, calculate the maximum height `max_h_i` that can be cleared at index `i`
    // within `T` seconds.
    // This `max_h_i` is `T` if it's cleared by being chosen `T` times.
    // This `max_h_i` is `T + T` if it's cleared by being chosen `T` times AND getting gravity `T` times.
    // The gravity part is `T - (time_to_reach_zero_from_left_neighbor)` and `T - (time_to_reach_zero_from_right_neighbor)`.

    // Calculate `max_reachable_height[i]` for each `i` if `T` seconds pass.
    // `max_reachable_height[i]` is the maximum height that `mountains[i]` can be,
    // such that it can be cleared in `T` seconds.
    // This value is `T` (if only chosen operations are used) plus `T - k` (if gravity applies for `T-k` seconds).
    // `k` is the number of seconds that a zero has propagated to `i` or its neighbors.
    // `k` is `0` if `i` is in a continuous block of positive heights.
    // `k` is `distance_to_nearest_zero` if `i` is near a zero.

    // Let `max_cleared_height[i]` be the maximum height that can be cleared at index `i` in `T` seconds.
    // This is `T` (from chosen operations) + `T` (from gravity, if always active).
    // The gravity effect is limited by the distance from a "zero-wave".
    // For each `i`, `mountains[i]` must be `<= T + (T - distance_to_nearest_zero_wave_from_left)`
    // and `<= T + (T - distance_to_nearest_zero_wave_from_right)`.
    // This is `mountains[i] <= 2T - distance_to_nearest_zero_wave`.

    // Let `needed_chosen_ops[i]` be the number of times mountain `i` must be chosen.
    // `needed_chosen_ops[i] = max(0, mountains[i] - (T - k_i))`.
    // Where `k_i` is the minimum time for a zero to reach `i` from either side.
    // `k_i` is `0` if `i` is in a continuous block of positive heights.
    // `k_i` is `dist` if `i` is `dist` positions away from the nearest zero.

    // Let's compute `max_h_can_clear[i]` for each `i` in `T` seconds.
    // This value is `T` (from direct operations) + `T` (from gravity).
    // The gravity part is limited by how long the neighbors stay positive.
    // A mountain `i` can decrease by 2 per second if `mountains[i] > 0` and its neighbors are `>0`, and it's chosen.
    // Or by 1 per second if `mountains[i] > 0` and its neighbors are `>0`, and it's NOT chosen.
    // Or by 1 per second if `mountains[i] > 0` and at least one neighbor is `0`, and it's chosen.

    // Consider the problem from the perspective of how much 'extra' height each mountain `i` has
    // that cannot be cleared by the 'free' gravity reductions.
    // A mountain `i` can be reduced by gravity for `T` seconds if its neighbors are always positive.
    // So, `mountains[i] - T` is the 'extra' height that needs to be cleared by 'chosen' operations.
    // The total sum of these 'extra' heights must be `<= T`.
    // This is the simplified model.

    // The actual model:
    // For each mountain `i`, its height `mountains[i]` must be reduced to `0`.
    // In `T` seconds, mountain `i` can be reduced by `T` times by being chosen.
    // It can also be reduced by gravity.
    // The gravity effect on `i` continues as long as `mountains[i-1]` and `mountains[i+1]` are positive.
    // The maximum height `H_max` is the bottleneck.
    // For each `i`, `mountains[i]` must be `<= T` if it's at the edge of a block of positive heights.
    // `mountains[i]` must be `<= T + (T - dist_to_zero)` if it's in the interior.
    // `dist_to_zero` is the minimum number of steps (seconds) for a zero to reach `i` from either side.

    // Let `max_possible_height[i]` be the maximum height that can be cleared at index `i` in `T` seconds.
    // This is `T` (from direct chosen ops) + `T` (from gravity, if always active).
    // The gravity part is limited by the time it takes for a zero to propagate to its neighbors.
    // `max_possible_height[i] = T + max(0LL, T - min_time_to_zero_neighbor_left, T - min_time_to_zero_neighbor_right)`
    // where `min_time_to_zero_neighbor_left` is the time it takes for `mountains[(i-1+n)%n]` to become 0.
    // This is recursive.

    // A simpler approach for `check(T)`:
    // We have `T` "chosen" operations.
    // For each mountain `i`, its height `mountains[i]` must be reduced to 0.
    // Let `h_i = mountains[i]`.
    // The number of times `i` can be reduced by gravity is `g_i`.
    // The number of times `i` is chosen is `c_i`.
    // `c_i + g_i = h_i`.
    // `sum(c_i) <= T`.

    // The gravity effect on `i` is active if `h_i > 0`, `h_{i-1} > 0`, `h_{i+1} > 0`.
    // This means if we have a contiguous block of positive heights, the interior mountains get gravity.
    // The mountains at the ends of