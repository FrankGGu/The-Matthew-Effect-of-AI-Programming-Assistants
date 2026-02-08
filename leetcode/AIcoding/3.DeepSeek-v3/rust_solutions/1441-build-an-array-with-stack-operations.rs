impl Solution {
    pub fn build_array(target: Vec<i32>, n: i32) -> Vec<String> {
        let mut res = Vec::new();
        let mut current = 1;
        for num in target {
            while current < num {
                res.push("Push".to_string());
                res.push("Pop".to_string());
                current += 1;
            }
            res.push("Push".to_string());
            current += 1;
        }
        res
    }
}