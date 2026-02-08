fn replace_non_coprimes(nums: Vec<i32>) -> Vec<i32> {
    let mut stack: Vec<i32> = Vec::new();
    for num in nums {
        let mut curr = num;
        while !stack.is_empty() {
            let top = *stack.last().unwrap();
            let gcd = gcd(top, curr);
            if gcd == 1 {
                break;
            }
            curr = curr / gcd * top;
            stack.pop();
        }
        stack.push(curr);
    }
    stack
}

fn gcd(a: i32, b: i32) -> i32 {
    if b == 0 {
        return a;
    }
    gcd(b, a % b)
}