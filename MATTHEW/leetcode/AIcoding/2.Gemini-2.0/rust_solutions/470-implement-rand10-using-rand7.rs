impl Solution {
    fn rand10() -> i32 {
        loop {
            let row = (Solution::rand7() - 1) * 7;
            let col = Solution::rand7();
            let idx = row + col;
            if idx <= 40 {
                return idx % 10 + 1;
            }
        }
    }
}