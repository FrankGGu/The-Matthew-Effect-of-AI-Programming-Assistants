impl Solution {
    pub fn reverse(x: i32) -> i32 {
        let sign = if x < 0 { -1 } else { 1 };
        let reversed = x.abs().to_string().chars().rev().collect::<String>().parse::<i32>().unwrap_or(0);
        if reversed > i32::MAX as u32 { 0 } else { sign * reversed }
    }
}