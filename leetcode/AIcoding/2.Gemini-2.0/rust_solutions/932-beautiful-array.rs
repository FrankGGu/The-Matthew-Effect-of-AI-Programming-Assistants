impl Solution {
    pub fn beautiful_array(n: i32) -> Vec<i32> {
        let mut ans = vec![1];
        while ans.len() < n as usize {
            let mut temp = Vec::new();
            for &x in &ans {
                if x * 2 - 1 <= n {
                    temp.push(x * 2 - 1);
                }
            }
            for &x in &ans {
                if x * 2 <= n {
                    temp.push(x * 2);
                }
            }
            ans = temp;
        }
        ans
    }
}