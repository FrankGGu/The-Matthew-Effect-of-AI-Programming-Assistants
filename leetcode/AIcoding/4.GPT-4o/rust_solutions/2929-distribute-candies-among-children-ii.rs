pub fn distribute_candies(candies: i32, num_children: i32) -> Vec<i32> {
    let mut result = vec![0; num_children as usize];
    let mut remaining_candies = candies;
    let mut current_candies = 0;

    while remaining_candies > 0 {
        for i in 0..num_children {
            if remaining_candies > 0 {
                current_candies += 1;
                result[i as usize] += current_candies.min(remaining_candies);
                remaining_candies -= current_candies.min(remaining_candies);
            }
        }
    }

    result
}