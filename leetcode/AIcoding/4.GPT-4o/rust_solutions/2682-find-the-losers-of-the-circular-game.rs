pub fn find_losers(n: i32, k: i32) -> Vec<i32> {
    let mut losers = vec![true; n as usize];
    let mut index = 0;
    for round in 0..n {
        index = (index + k as usize - 1) % (n - round) as usize;
        losers[index] = false;
        for j in index..(n - round - 1) as usize {
            losers[j] = losers[j + 1];
        }
    }
    losers.iter().enumerate()
        .filter_map(|(i, &is_loser)| if is_loser { Some(i as i32 + 1) } else { None })
        .collect()
}