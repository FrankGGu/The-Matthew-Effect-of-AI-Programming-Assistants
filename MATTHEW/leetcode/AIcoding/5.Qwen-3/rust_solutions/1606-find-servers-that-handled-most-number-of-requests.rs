impl Solution {

use std::collections::{BinaryHeap, HashSet};

struct Server {
    id: i32,
    available_time: i32,
}

impl Server {
    fn new(id: i32, available_time: i32) -> Self {
        Server { id, available_time }
    }
}

#[derive(PartialEq, Eq, Clone, Copy)]
struct AvailableServer {
    available_time: i32,
    id: i32,
}

impl PartialOrd for AvailableServer {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl Ord for AvailableServer {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        match self.available_time.cmp(&other.available_time) {
            std::cmp::Ordering::Equal => self.id.cmp(&other.id),
            other => other,
        }
    }
}

impl PartialEq for AvailableServer {
    fn eq(&self, other: &Self) -> bool {
        self.available_time == other.available_time && self.id == other.id
    }
}

impl Eq for AvailableServer {}

fn find_servers_that_handled_most_number_of_requests(
    requests: Vec<Vec<i32>>,
    k: i32,
) -> Vec<i32> {
    let mut server_count = vec![0; k as usize];
    let mut available_servers = BinaryHeap::new();
    for i in 0..k {
        available_servers.push(AvailableServer {
            available_time: 0,
            id: i,
        });
    }

    let mut busy_servers = BinaryHeap::new();

    for request in requests {
        let time = request[0];
        let server_id = request[1];

        while let Some(server) = busy_servers.peek() {
            if server.available_time > time {
                break;
            }
            let server = busy_servers.pop().unwrap();
            available_servers.push(AvailableServer {
                available_time: server.available_time,
                id: server.id,
            });
        }

        if let Some(server) = available_servers.pop() {
            server_count[server.id as usize] += 1;
            busy_servers.push(AvailableServer {
                available_time: time + request[2],
                id: server.id,
            });
        } else {
            continue;
        }
    }

    let max_requests = server_count.iter().max().copied().unwrap_or(0);
    let mut result = Vec::new();
    for (i, &count) in server_count.iter().enumerate() {
        if count == max_requests {
            result.push(i as i32);
        }
    }

    result.sort();
    result
}
}