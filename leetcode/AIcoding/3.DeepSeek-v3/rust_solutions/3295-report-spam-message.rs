use std::collections::{HashMap, HashSet};

struct ReportSystem {
    reported: HashMap<String, HashSet<String>>,
    banned: HashSet<String>,
}

impl ReportSystem {
    fn new() -> Self {
        ReportSystem {
            reported: HashMap::new(),
            banned: HashSet::new(),
        }
    }

    fn report(&mut self, reporter: String, spammer: String) {
        self.reported.entry(spammer).or_insert_with(HashSet::new).insert(reporter);
    }

    fn get_banned(&mut self, k: i32) -> Vec<String> {
        let mut spammers: Vec<_> = self.reported.iter().collect();
        spammers.sort_by(|a, b| b.1.len().cmp(&a.1.len()));

        let mut res = Vec::new();
        for (spammer, reporters) in spammers {
            if reporters.len() >= k as usize && !self.banned.contains(spammer) {
                self.banned.insert(spammer.clone());
                res.push(spammer.clone());
            }
        }
        res
    }
}

struct Solution;

impl Solution {
    fn spam_report(reporters: Vec<String>, spammers: Vec<String>, k: i32) -> Vec<String> {
        let mut system = ReportSystem::new();
        for (reporter, spammer) in reporters.into_iter().zip(spammers.into_iter()) {
            system.report(reporter, spammer);
        }
        system.get_banned(k)
    }
}