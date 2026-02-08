use std::cmp::Ordering;
use std::collections::BinaryHeap;

#[derive(Eq, PartialEq)]
struct AvailableServer {
    weight: i32,
    index: usize,
}

impl Ord for AvailableServer {
    fn cmp(&self, other: &Self) -> Ordering {
        match self.weight.cmp(&other.weight) {
            Ordering::Equal => self.index.cmp(&other.index),
            ord => ord,
        }
    }
}

impl PartialOrd for AvailableServer {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

#[derive(Eq, PartialEq)]
struct BusyServer {
    available_time: i32,
    server: AvailableServer,
}

impl Ord for BusyServer {
    fn cmp(&self, other: &Self) -> Ordering {
        other.available_time.cmp(&self.available_time)
            .then_with(|| self.server.cmp(&other.server))
    }
}

impl PartialOrd for BusyServer {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn assign_tasks(servers: Vec<i32>, tasks: Vec<i32>) -> Vec<i32> {
        let mut available_servers: BinaryHeap<AvailableServer> = BinaryHeap::new();
        for (i, &weight) in servers.iter().enumerate() {
            available_servers.push(AvailableServer { weight, index: i });
        }

        let mut busy_servers: BinaryHeap<BusyServer> = BinaryHeap::new();
        let mut res = Vec::with_capacity(tasks.len());

        for (current_time, &task_time) in tasks.iter().enumerate() {
            let current_time = current_time as i32;

            while let Some(busy) = busy_servers.peek() {
                if busy.available_time > current_time {
                    break;
                }
                let busy = busy_servers.pop().unwrap();
                available_servers.push(busy.server);
            }

            if let Some(server) = available_servers.pop() {
                res.push(server.index as i32);
                busy_servers.push(BusyServer {
                    available_time: current_time + task_time,
                    server,
                });
            } else {
                let busy = busy_servers.pop().unwrap();
                res.push(busy.server.index as i32);
                busy_servers.push(BusyServer {
                    available_time: busy.available_time + task_time,
                    server: busy.server,
                });
            }
        }

        res
    }
}