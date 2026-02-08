use std::collections::BinaryHeap;
use std::cmp::Reverse;

#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
struct Interval {
    start: i32,
    end: i32,
}

impl Interval {
    fn new(start: i32, end: i32) -> Self {
        Interval { start, end }
    }
}

impl Solution {
    pub fn max_available_range(meetings: Vec<Vec<i32>>) -> i32 {
        let mut intervals: Vec<Interval> = meetings
            .into_iter()
            .map(|m| Interval::new(m[0], m[1]))
            .collect();
        intervals.sort_by_key(|i| i.start);

        let mut available_range = 0;
        let mut current_end = i32::MIN;
        for interval in intervals {
            if interval.start > current_end {
                available_range += interval.start - current_end;
            }
            current_end = current_end.max(interval.end);
        }

        available_range
    }

    pub fn max_available_range_of_workers(meetings: Vec<Vec<i32>>) -> i32 {
        let mut intervals: Vec<Interval> = meetings
            .into_iter()
            .map(|m| Interval::new(m[0], m[1]))
            .collect();
        intervals.sort_by_key(|i| i.start);

        let mut available_range = 0;
        if intervals.len() > 0 {
            available_range = intervals[0].end - intervals[0].start;
            for i in 1..intervals.len() {
                available_range += intervals[i].end - intervals[i].start;
            }
        }
        available_range
    }

    pub fn max_available_range_of_workers_after_reschedule(meetings: Vec<Vec<i32>>, worker_meetings: Vec<Vec<i32>>) -> i32 {
        let mut all_intervals: Vec<Interval> = worker_meetings
            .into_iter()
            .map(|m| Interval::new(m[0], m[1]))
            .collect();
        for meeting in meetings {
            all_intervals.push(Interval::new(meeting[0], meeting[1]));
        }

        all_intervals.sort_by_key(|i| i.start);
        let mut merged_intervals: Vec<Interval> = Vec::new();
        if all_intervals.len() > 0 {
            merged_intervals.push(all_intervals[0]);
            for i in 1..all_intervals.len() {
                let last_merged = merged_intervals.last_mut().unwrap();
                if all_intervals[i].start <= last_merged.end {
                    last_merged.end = last_merged.end.max(all_intervals[i].end);
                } else {
                    merged_intervals.push(all_intervals[i]);
                }
            }
        }

        let mut busy_time = 0;
        for interval in merged_intervals {
            busy_time += interval.end - interval.start;
        }

        let total_time = i32::MAX;

        total_time.min(busy_time)
    }

    pub fn max_available_range_of_workers_after_reschedule_II(meetings: Vec<Vec<i32>>, worker_meetings: Vec<Vec<i32>>) -> i32 {
        let mut all_intervals: Vec<Interval> = worker_meetings
            .into_iter()
            .map(|m| Interval::new(m[0], m[1]))
            .collect();
        for meeting in meetings {
            all_intervals.push(Interval::new(meeting[0], meeting[1]));
        }

        all_intervals.sort_by_key(|i| i.start);
        let mut merged_intervals: Vec<Interval> = Vec::new();
        if all_intervals.len() > 0 {
            merged_intervals.push(all_intervals[0]);
            for i in 1..all_intervals.len() {
                let last_merged = merged_intervals.last_mut().unwrap();
                if all_intervals[i].start <= last_merged.end {
                    last_merged.end = last_merged.end.max(all_intervals[i].end);
                } else {
                    merged_intervals.push(all_intervals[i]);
                }
            }
        }

        let mut busy_time = 0;
        for interval in merged_intervals {
            busy_time += interval.end - interval.start;
        }

        busy_time
    }

    pub fn max_available_range_of_workers_before_reschedule_II(worker_meetings: Vec<Vec<i32>>) -> i32 {
        let mut intervals: Vec<Interval> = worker_meetings
            .into_iter()
            .map(|m| Interval::new(m[0], m[1]))
            .collect();

        intervals.sort_by_key(|i| i.start);
        let mut merged_intervals: Vec<Interval> = Vec::new();
        if intervals.len() > 0 {
            merged_intervals.push(intervals[0]);
            for i in 1..intervals.len() {
                let last_merged = merged_intervals.last_mut().unwrap();
                if intervals[i].start <= last_merged.end {
                    last_merged.end = last_merged.end.max(intervals[i].end);
                } else {
                    merged_intervals.push(intervals[i]);
                }
            }
        }

        let mut busy_time = 0;
        for interval in merged_intervals {
            busy_time += interval.end - interval.start;
        }

        busy_time
    }

    pub fn max_available_range_of_workers_after_reschedule_III(meetings: Vec<Vec<i32>>, worker_meetings: Vec<Vec<i32>>) -> i32 {
        let mut all_intervals: Vec<Interval> = worker_meetings
            .into_iter()
            .map(|m| Interval::new(m[0], m[1]))
            .collect();
        for meeting in meetings {
            all_intervals.push(Interval::new(meeting[0], meeting[1]));
        }

        all_intervals.sort_by_key(|i| i.start);
        let mut merged_intervals: Vec<Interval> = Vec::new();
        if all_intervals.len() > 0 {
            merged_intervals.push(all_intervals[0]);
            for i in 1..all_intervals.len() {
                let last_merged = merged_intervals.last_mut().unwrap();
                if all_intervals[i].start <= last_merged.end {
                    last_merged.end = last_merged.end.max(all_intervals[i].end);
                } else {
                    merged_intervals.push(all_intervals[i]);
                }
            }
        }

        let mut busy_time = 0;
        for interval in merged_intervals {
            busy_time += interval.end - interval.start;
        }

        busy_time
    }

    pub fn max_available_range_of_workers_before_reschedule_III(worker_meetings: Vec<Vec<i32>>) -> i32 {
        let mut intervals: Vec<Interval> = worker_meetings
            .into_iter()
            .map(|m| Interval::new(m[0], m[1]))
            .collect();

        intervals.sort_by_key(|i| i.start);
        let mut merged_intervals: Vec<Interval> = Vec::new();
        if intervals.len() > 0 {
            merged_intervals.push(intervals[0]);
            for i in 1..intervals.len() {
                let last_merged = merged_intervals.last_mut().unwrap();
                if intervals[i].start <= last_merged.end {
                    last_merged.end = last_merged.end.max(intervals[i].end);
                } else {
                    merged_intervals.push(intervals[i]);
                }
            }
        }

        let mut busy_time =