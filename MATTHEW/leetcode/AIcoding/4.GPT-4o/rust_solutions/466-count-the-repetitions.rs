pub fn get_max_repetitions(s1: String, n1: i32, s2: String, n2: i32) -> i32 {
    let (mut count1, mut count2) = (0, 0);
    let (len1, len2) = (s1.len(), s2.len());
    let (mut i, mut j) = (0, 0);

    let mut memo = std::collections::HashMap::new();

    while count1 < n1 {
        if s1.as_bytes()[i % len1] == s2.as_bytes()[j % len2] {
            j += 1;
            if j == len2 {
                count2 += 1;
                j = 0;
            }
        }
        i += 1;
        if i % len1 == 0 {
            count1 += 1;
            if let Some(&(prev_count1, prev_count2)) = memo.get(&(i / len1, count2)) {
                let loop_count = (n1 - count1) / (count1 - prev_count_count1);
                count1 += loop_count * (count1 - prev_count_count1);
                count2 += loop_count * (count2 - prev_count_count2);
                break;
            } else {
                memo.insert((i / len1, count2), (count1, count2));
            }
        }
    }

    count2 / n2
}