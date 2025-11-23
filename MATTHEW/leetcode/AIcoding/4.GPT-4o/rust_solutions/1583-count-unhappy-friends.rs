pub fn unhappy_friends(n: i32, preferences: Vec<Vec<i32>>, pairs: Vec<Vec<i32>>) -> i32 {
    let mut preference_rank = vec![vec![0; n as usize]; n as usize];
    let mut partner = vec![0; n as usize];

    for (i, pair) in pairs.iter().enumerate() {
        partner[pair[0] as usize] = pair[1];
        partner[pair[1] as usize] = pair[0];
    }

    for (i, pref) in preferences.iter().enumerate() {
        for (rank, &friend) in pref.iter().enumerate() {
            preference_rank[i][friend as usize] = rank;
        }
    }

    let mut unhappy_count = 0;

    for i in 0..n {
        let p = partner[i as usize];
        for &friend in &preferences[i as usize] {
            if preference_rank[i as usize][friend as usize] < preference_rank[i as usize][p as usize] {
                if preference_rank[friend as usize][i] < preference_rank[friend as usize][partner[friend as usize]] {
                    unhappy_count += 1;
                    break;
                }
            }
        }
    }

    unhappy_count
}