impl Solution {
    pub fn shortest_sequence(rolls: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let mut seen = vec![false; k];
        let mut count = 0;

        for &roll in &rolls {
            let roll_usize = (roll - 1) as usize;
            if !seen[roll_usize] {
                seen[roll_usize] = true;
                if seen.iter().all(|&x| x) {
                    count += 1;
                    seen = vec![false; k];
                }
            }
        }

        count + 1
    }
}