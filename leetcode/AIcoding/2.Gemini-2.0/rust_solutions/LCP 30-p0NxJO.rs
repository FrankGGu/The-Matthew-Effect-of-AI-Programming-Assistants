impl Solution {
    pub fn magic_tower(nums: Vec<i32>) -> i32 {
        let mut hp: i64 = 1;
        let mut sum: i64 = 0;
        let mut pq: std::collections::BinaryHeap<i32> = std::collections::BinaryHeap::new();
        let mut ans: i32 = 0;

        for &num in &nums {
            sum += num as i64;
            if num < 0 {
                pq.push(num);
            }
            hp += num as i64;
            while hp <= 0 {
                if pq.is_empty() {
                    return -1;
                }
                let top = pq.pop().unwrap();
                hp -= top as i64;
                sum -= top as i64;
                ans += 1;
            }
        }

        if sum + 1 > 0 {
            return ans;
        } else {
            return -1;
        }
    }
}