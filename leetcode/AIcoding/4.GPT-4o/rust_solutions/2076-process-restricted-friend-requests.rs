impl Solution {
    pub fn num_friend_requests(names: Vec<String>, restrictions: Vec<Vec<String>>) -> Vec<i32> {
        let n = names.len();
        let mut requests = vec![0; n];
        let mut can_request = vec![vec![true; n]; n];

        for restriction in &restrictions {
            let (a, b) = (restriction[0].clone(), restriction[1].clone());
            let a_index = names.iter().position(|x| *x == a).unwrap();
            let b_index = names.iter().position(|x| *x == b).unwrap();
            can_request[a_index][b_index] = false;
            can_request[b_index][a_index] = false;
        }

        for i in 0..n {
            for j in 0..n {
                if i != j && can_request[i][j] && names[i].len() > names[j].len() {
                    requests[i] += 1;
                }
            }
        }

        requests
    }
}