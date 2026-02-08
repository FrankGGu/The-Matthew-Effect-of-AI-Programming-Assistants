impl Solution {
    pub fn min_increments(nums: Vec<i32>, k: i32) -> i64 {
        if k == 1 {
            return 0;
        }

        let mut heap: std::collections::BinaryHeap<i32> = std::collections::BinaryHeap::new();
        let mut ans: i64 = 0;

        for &num in &nums {
            if num % k != 0 {
                heap.push(std::cmp::Reverse(num % k));
            }
            if heap.len() >= 2 {
                let a = heap.pop().unwrap().0;
                let b = heap.pop().unwrap().0;
                ans += (a + b) as i64;
                heap.push(std::cmp::Reverse((a + b) % k));
            }
        }

        while heap.len() > 1 {
            let a = heap.pop().unwrap().0;
            let b = heap.pop().unwrap().0;
            ans += (a + b) as i64;
            heap.push(std::cmp::Reverse((a + b) % k));
        }

        ans
    }
}