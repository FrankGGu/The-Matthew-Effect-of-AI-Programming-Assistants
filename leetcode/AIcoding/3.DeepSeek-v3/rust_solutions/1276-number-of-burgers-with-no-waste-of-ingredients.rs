impl Solution {
    pub fn num_of_burgers(tomato_slices: i32, cheese_slices: i32) -> Vec<i32> {
        let total_jumbo = (tomato_slices - 2 * cheese_slices) / 2;
        let total_small = cheese_slices - total_jumbo;

        if (tomato_slices - 2 * cheese_slices) % 2 == 0 
            && total_jumbo >= 0 
            && total_small >= 0 {
            vec![total_jumbo, total_small]
        } else {
            vec![]
        }
    }
}