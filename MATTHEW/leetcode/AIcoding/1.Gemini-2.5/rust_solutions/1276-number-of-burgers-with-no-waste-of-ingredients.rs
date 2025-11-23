impl Solution {
    pub fn number_of_burgers(total_tomato_slices: i32, total_cheese_slices: i32) -> Vec<i32> {
        if total_tomato_slices % 2 != 0 ||
           total_tomato_slices < 2 * total_cheese_slices ||
           total_tomato_slices > 4 * total_cheese_slices {
            return Vec::new();
        }

        let jumbo_burgers = (total_tomato_slices - 2 * total_cheese_slices) / 2;
        let small_burgers = (4 * total_cheese_slices - total_tomato_slices) / 2;

        vec![jumbo_burgers, small_burgers]
    }
}