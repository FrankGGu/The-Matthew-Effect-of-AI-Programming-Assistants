use std::collections::HashMap;

pub fn busiest_servers(k: i32, arrival: Vec<i32>, load: Vec<i32>) -> Vec<i32> {
    let n = arrival.len();
    let mut busy_until = vec![0; k as usize];
    let mut count = vec![0; k as usize];
    let mut free_servers = (0..k).collect::<Vec<_>>();
    let mut busy_servers = vec![];

    for i in 0..n {
        let start_time = arrival[i];
        let end_time = start_time + load[i];

        while !busy_servers.is_empty() && busy_servers[0].0 <= start_time {
            free_servers.push(busy_servers.remove(0).1);
        }

        if free_servers.is_empty() {
            continue;
        }

        let server_index = free_servers.remove(0);
        busy_servers.push((end_time, server_index));
        count[server_index as usize] += 1;
    }

    let max_requests = *count.iter().max().unwrap();
    count.iter()
        .enumerate()
        .filter_map(|(i, &c)| if c == max_requests { Some(i as i32) } else { None })
        .collect()
}