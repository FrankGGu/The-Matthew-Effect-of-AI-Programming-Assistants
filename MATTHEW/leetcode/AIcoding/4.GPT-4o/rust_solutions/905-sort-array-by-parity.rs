impl Solution {
    pub fn sort_array_by_parity(a: Vec<i32>) -> Vec<i32> {
        let mut even = Vec::new();
        let mut odd = Vec::new();

        for &num in &a {
            if num % 2 == 0 {
                even.push(num);
            } else {
                odd.push(num);
            }
        }

        even.extend(odd);
        even
    }
}