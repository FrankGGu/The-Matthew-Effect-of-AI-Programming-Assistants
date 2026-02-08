struct Solution;

impl Solution {
    pub fn max_consecutive(bottom: i32, top: i32, special: Vec<i32>) -> i32 {
        let mut special_floors = special;
        special_floors.sort_unstable();

        let mut max_consecutive_floors = 0;

        // Calculate the length of the consecutive block from `bottom` to the first special floor.
        // The floors are `bottom, bottom + 1, ..., special_floors[0] - 1`.
        // The number of such floors is `(special_floors[0] - 1) - bottom + 1 = special_floors[0] - bottom`.
        max_consecutive_floors = std::cmp::max(max_consecutive_floors, special_floors[0] - bottom);

        // Calculate the length of consecutive blocks between adjacent special floors.
        // For a pair of special floors `special_floors[i]` and `special_floors[i+1]`,
        // the non-special floors are `special_floors[i] + 1, ..., special_floors[i+1] - 1`.
        // The number of such floors is `(special_floors[i+1] - 1) - (special_floors[i] + 1) + 1 = special_floors[i+1] - special_floors[i] - 1`.
        for i in 0..special_floors.len() - 1 {
            max_consecutive_floors = std::cmp::max(
                max_consecutive_floors,
                special_floors[i+1] - special_floors[i] - 1,
            );
        }

        // Calculate the length of the consecutive block from the last special floor to `top`.
        // The floors are `special_floors[last] + 1, ..., top`.
        // The number of such floors is `top - (special_floors[last] + 1) + 1 = top - special_floors[last]`.
        max_consecutive_floors = std::cmp::max(
            max_consecutive_floors,
            top - special_floors[special_floors.len() - 1],
        );

        max_consecutive_floors
    }
}