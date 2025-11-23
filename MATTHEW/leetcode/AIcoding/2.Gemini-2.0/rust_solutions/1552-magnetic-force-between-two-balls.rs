impl Solution {
    pub fn max_distance(position: Vec<i32>, m: i32) -> i32 {
        let mut position = position;
        position.sort();
        let mut low = 1;
        let mut high = position[position.len() - 1] - position[0];
        let mut ans = 0;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::can_place(&position, m, mid) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        ans
    }

    fn can_place(position: &Vec<i32>, m: i32, dist: i32) -> bool {
        let mut count = 1;
        let mut last_pos = position[0];

        for i in 1..position.len() {
            if position[i] - last_pos >= dist {
                count += 1;
                last_pos = position[i];
            }
        }

        count >= m
    }
}