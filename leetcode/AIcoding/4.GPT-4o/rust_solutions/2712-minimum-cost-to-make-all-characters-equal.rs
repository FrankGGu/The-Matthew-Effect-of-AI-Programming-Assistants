impl Solution {
    pub fn minimum_cost(s: String) -> i32 {
        let mut count = vec![0; 26];
        for c in s.chars() {
            count[(c as usize) - ('a' as usize)] += 1;
        }
        let n = s.len();
        let mut min_cost = i32::MAX;
        for i in 0..26 {
            let cost = count.iter().enumerate().map(|(j, &c)| if j != i { c } else { 0 }).sum::<i32>();
            min_cost = min_cost.min(cost);
        }
        min_cost
    }
}