impl Solution {
    pub fn magical_string(n: i32) -> i32 {
        if n == 0 { return 0; }
        if n == 1 { return 1; }

        let mut magical = vec![1, 2, 2];
        let mut count = 1;
        let mut index = 2;

        while magical.len() < n as usize {
            let next_count = magical[index];
            let next_num = if magical.last().unwrap() == &1 { 2 } else { 1 };
            for _ in 0..next_count {
                magical.push(next_num);
                if magical.len() == n as usize {
                    break;
                }
            }
            index += 1;
        }

        magical.iter().take(n as usize).filter(|&&x| x == 1).count() as i32
    }
}