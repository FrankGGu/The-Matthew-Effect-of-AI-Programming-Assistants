pub fn beautiful_substrings(s: String) -> i32 {
    let n = s.len();
    let mut ans = 0;
    let mut count = vec![0; 4];
    count[0] = 1;

    for i in 0..n {
        let mut sum = 0;
        for j in i..n {
            sum += if s.chars().nth(j).unwrap() == '1' { 1 } else { -1 };
            if sum >= 0 && sum < 4 {
                ans += count[sum as usize];
                count[sum as usize] += 1;
            }
        }
        count.iter_mut().for_each(|x| *x = 0);
        count[0] = 1;
    }
    ans
}