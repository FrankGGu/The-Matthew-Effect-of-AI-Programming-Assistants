impl Solution {
    pub fn find_champion(n: i32, battles: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut defeated = vec![false; n];

        for battle in battles {
            let loser = battle[1] as usize;
            defeated[loser] = true;
        }

        let mut champion_candidate = -1;
        let mut champion_count = 0;

        for i in 0..n {
            if !defeated[i] {
                champion_candidate = i as i32;
                champion_count += 1;
            }
        }

        if champion_count == 1 {
            champion_candidate
        } else {
            -1
        }
    }
}