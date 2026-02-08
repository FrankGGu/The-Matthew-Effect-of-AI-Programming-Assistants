pub fn count_hidden_sequences(n: i32, seq: Vec<i32>) -> i32 {
    let mut count = 0;
    for i in 0..(1 << n) {
        let mut valid = true;
        let mut j = 0;
        for k in 0..n {
            if (i & (1 << k)) != 0 {
                if j < seq.len() && seq[j] == k + 1 {
                    j += 1;
                }
            }
        }
        if j == seq.len() {
            count += 1;
        }
    }
    count
}