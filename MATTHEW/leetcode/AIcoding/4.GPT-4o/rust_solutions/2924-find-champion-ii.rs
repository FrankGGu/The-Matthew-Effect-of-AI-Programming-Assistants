pub fn find_champion(n: i32, rounds: Vec<Vec<i32>>) -> i32 {
    let mut scores = vec![0; n as usize + 1];
    for round in rounds {
        scores[round[0] as usize] += 1;
        scores[round[1] as usize] -= 1;
    }
    for i in 1..=n {
        if scores[i as usize] == n - rounds.len() as i32 {
            return i;
        }
    }
    -1
}