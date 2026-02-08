use std::collections::{BTreeSet, BinaryHeap};

impl Solution {
    pub fn busiest_servers(k: i32, arrival: Vec<i32>, load: Vec<i32>) -> Vec<i32> {
        let k = k as usize;
        let mut available: BTreeSet<usize> = (0..k).collect();
        let mut busy: BinaryHeap<(i32, usize)> = BinaryHeap::new();
        let mut count = vec![0; k];

        for i in 0..arrival.len() {
            let time = arrival[i];
            let duration = load[i];
            let server = i % k;

            while let Some(&(end, s)) = busy.peek() {
                if -end > time {
                    break;
                }
                busy.pop();
                available.insert(s);
            }

            if let Some(&s) = available.range(server..).next() {
                available.remove(&s);
                busy.push((-time - duration, s));
                count[s] += 1;
            } else if let Some(&s) = available.range(..server).next() {
                available.remove(&s);
                busy.push((-time - duration, s));
                count[s] += 1;
            }
        }

        let max = *count.iter().max().unwrap();
        count.iter().enumerate().filter(|(_, &c)| c == max).map(|(i, _)| i as i32).collect()
    }
}