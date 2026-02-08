impl Solution {
    pub fn mct_from_leaf_values(arr: Vec<i32>) -> i32 {
        let mut ans = 0;
        let mut stack: Vec<i32> = Vec::new();
        stack.push(std::i32::MAX); // Sentinel value to handle the first element

        for &a in arr.iter() {
            while let Some(&top) = stack.last() {
                if top <= a {
                    let mid = stack.pop().unwrap();
                    ans += mid * stack.last().unwrap().min(a);
                } else {
                    break;
                }
            }
            stack.push(a);
        }

        // After iterating through arr, process remaining elements in the stack
        // The stack will contain elements in decreasing order, ending with the sentinel.
        // We need to combine them until only the sentinel and one element remain.
        while stack.len() > 2 {
            let mid = stack.pop().unwrap();
            ans += mid * stack.last().unwrap();
        }

        ans
    }
}