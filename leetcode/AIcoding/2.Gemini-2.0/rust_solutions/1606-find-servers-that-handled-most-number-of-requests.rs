use std::collections::BTreeMap;

impl Solution {
    pub fn find_servers(k: i32, arrival: Vec<i32>, duration: Vec<i32>) -> Vec<i32> {
        let k = k as usize;
        let n = arrival.len();
        let mut available: BTreeMap<i32, usize> = BTreeMap::new();
        for i in 0..k {
            available.insert(i as i32, i);
        }
        let mut busy: BTreeMap<i32, usize> = BTreeMap::new();
        let mut count = vec![0; k];

        for i in 0..n {
            while !busy.is_empty() && busy.first_key_value().unwrap().0 <= &arrival[i] {
                let (&time, &server) = busy.first_key_value().unwrap();
                busy.remove(&time);
                available.insert(server as i32, server);
            }

            if available.is_empty() {
                continue;
            }

            let start_server = i as i32 % k as i32;
            let mut server_iter = available.range(start_server..);
            let server = match server_iter.next() {
                Some((_, &server)) => server,
                None => *available.first_key_value().unwrap().1,
            };

            available.remove(&(server as i32));
            busy.insert(arrival[i] + duration[i], server);
            count[server] += 1;
        }

        let max_count = *count.iter().max().unwrap();
        let mut result = Vec::new();
        for i in 0..k {
            if count[i] == max_count {
                result.push(i as i32);
            }
        }

        result
    }
}