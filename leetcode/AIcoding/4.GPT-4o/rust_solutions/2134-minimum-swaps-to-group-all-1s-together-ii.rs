impl Solution {
    pub fn min_swaps(data: Vec<i32>) -> i32 {
        let n = data.len();
        let ones_count = data.iter().filter(|&&x| x == 1).count();
        if ones_count == 0 {
            return 0;
        }

        let mut max_ones_in_window = 0;
        let mut ones_in_window = 0;

        for i in 0..n {
            if data[i] == 1 {
                ones_in_window += 1;
            }
            if i >= ones_count {
                if data[i - ones_count] == 1 {
                    ones_in_window -= 1;
                }
            }
            if i >= ones_count - 1 {
                max_ones_in_window = max_ones_in_window.max(ones_in_window);
            }
        }

        ones_count as i32 - max_ones_in_window as i32
    }
}