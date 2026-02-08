impl Solution {
    pub fn max_height(mut cuboids: Vec<Vec<i32>>) -> i32 {
        for cuboid in cuboids.iter_mut() {
            cuboid.sort_unstable();
        }

        cuboids.sort_unstable_by(|a, b| {
            if a[0] != b[0] {
                a[0].cmp(&b[0])
            } else if a[1] != b[1] {
                a[1].cmp(&b[1])
            } else {
                a[2].cmp(&b[2])
            }
        });

        let n = cuboids.len();
        let mut dp = vec![0; n];
        let mut max_h = 0;

        for i in 0..n {
            dp[i] = cuboids[i][2]; // Current cuboid's height
            for j in 0..i {
                // Check if cuboid[i] can be placed on top of cuboid[j]
                // Condition: widths_i <= widths_j and lengths_i <= lengths_j and heights_i <= heights_j
                // Since dimensions are sorted (d1 <= d2 <= d3), this means:
                // d1_i <= d1_j, d2_i <= d2_j, d3_i <= d3_j
                if cuboids[i][0] >= cuboids[j][0] && // d1_i >= d1_j
                   cuboids[i][1] >= cuboids[j][1] && // d2_i >= d2_j
                   cuboids[i][2] >= cuboids[j][2] {  // d3_i >= d3_j
                    // This is incorrect based on problem statement "widths_i <= widths_j".
                    // The cuboid on top must be smaller or equal in all dimensions.
                    // The sorting of cuboids should be such that if cuboid[j] comes before cuboid[i],
                    // it is a potential base.
                    // Let's re-evaluate the sorting and condition.
                    // If cuboid[i] is on top of cuboid[j], then cuboid[i] must be smaller or equal.
                    // So, cuboids[i][0] <= cuboids[j][0], cuboids[i][1] <= cuboids[j][1], cuboids[i][2] <= cuboids[j][2].
                    // The initial sort (lexicographical ascending) means if j < i, then cuboids[j] is "smaller or equal"
                    // lexicographically. This does NOT guarantee it can be a base.
                    // The standard approach for 3D LIS is to sort by largest dimension descending, then middle, then smallest.
                    // Or, sort by smallest ascending, then middle, then largest.
                    // Let's stick to the current lexicographical sort and the condition:
                    // if cuboids[i] is on cuboids[j], then cuboids[i] must be smaller than or equal to cuboids[j] in all dimensions.
                    // So we need: cuboids[i][0] <= cuboids[j][0], cuboids[i][1] <= cuboids[j][1], cuboids[i][2] <= cuboids[j][2].
                    // This is the condition for `cuboids[i]` to be on `cuboids[j]`.
                    // But if `cuboids` is sorted lexicographically ascending, `cuboids[j]` will always be lexicographically smaller or equal to `cuboids[i]`.
                    // So `cuboids[j][0] <= cuboids[i][0]` is generally true if dimensions are unique.
                    // The condition should be: `cuboids[j]` can be a base for `cuboids[i]`.
                    // This means `cuboids[j]` must be larger or equal in all dimensions.
                    // So `cuboids[j][0] <= cuboids[i][0]` is not the right condition.
                    // It should be `cuboids[i][0] <= cuboids[j][0]`, `cuboids[i][1] <= cuboids[j][1]`, `cuboids[i][2] <= cuboids[j][2]`.
                    // This is `cuboids[i]` is smaller than `cuboids[j]`.
                    // The sorting should be such that if `cuboids[j]` can be a base for `cuboids[i]`, then `j < i`.
                    // This means `cuboids[j]` should be "larger" than `cuboids[i]`.
                    // So, sort in descending order of dimensions.

                    // Let's retry the sorting. Sort by largest dimension (cuboid[2]) descending, then cuboid[1] descending, then cuboid[0] descending.
                    // This ensures that if cuboids[j] is before cuboids[i], it's "larger" in some sense.
                    // Then the DP condition is `cuboids[i]` on `cuboids[j]` means `cuboids[i]` is smaller than `cuboids[j]`.
                    // So `cuboids[i][0] <= cuboids[j][0]`, `cuboids[i][1] <= cuboids[j][1]`, `cuboids[i][2] <= cuboids[j][2]`.
                }
            }
        }

        // Corrected approach based on standard 3D LIS:
        // 1. Normalize each cuboid: sort its dimensions [d1, d2, d3] such that d1 <= d2 <= d3.
        // 2. Sort all cuboids: by d3 (height) in descending order, then d2 descending, then d1 descending.
        //    This ensures that if cuboids[j] comes before cuboids[i] in the sorted list, cuboids[j] is "larger" or "equal"
        //    in at least one dimension, making it a potential base.
        // 3. DP: dp[i] = maximum height of a stack ending with cuboids[i] as the topmost cuboid.
        //    Initialize dp[i] = cuboids[i][2] (its own height).
        //    For i from 0 to n-1:
        //        For j from 0 to i-1:
        //            If cuboids[i] can be placed on cuboids[j] (i.e., cuboids[i] is smaller or equal in all dimensions):
        //                cuboids[i][0] <= cuboids[j][0] AND cuboids[i][1] <= cuboids[j][1] AND cuboids[i][2] <= cuboids[j][2]
        //                dp[i] = max(dp[i], dp[j] + cuboids[i][2])
        // 4. The answer is max(dp).

        cuboids.sort_unstable_by(|a, b| {
            if a[2] != b[2] {
                b[2].cmp(&a[2]) // Sort by d3 descending
            } else if a[1] != b[1] {
                b[1].cmp(&a[1]) // Then by d2 descending
            } else {
                b[0].cmp(&a[0]) // Then by d1 descending
            }
        });

        let mut dp = vec![0; n];
        let mut max_total_height = 0;

        for i in 0..n {
            dp[i] = cuboids[i][2]; // A stack can be just this cuboid
            for j in 0..i {
                // Check if cuboids[i] can be placed on top of cuboids[j]
                // This means cuboids[i] must be smaller or equal in all dimensions than cuboids[j]
                if cuboids[i][0] <= cuboids[j][0] &&
                   cuboids[i][1] <= cuboids[j][1] &&
                   cuboids[i][2] <= cuboids[j][2] {
                    dp[i] = dp[i].max(dp[j] + cuboids[i][2]);
                }
            }
            max_total_height = max_total_height.max(dp[i]);
        }

        max_total_height
    }
}