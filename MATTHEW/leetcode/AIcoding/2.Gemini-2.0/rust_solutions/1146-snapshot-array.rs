struct SnapshotArray {
    snaps: Vec<Vec<(i32, i32)>>,
    snap_id: i32,
    arr: Vec<i32>,
}

impl SnapshotArray {
    fn new(length: i32) -> Self {
        SnapshotArray {
            snaps: vec![vec![(0, 0)]; length as usize],
            snap_id: 0,
            arr: vec![0; length as usize],
        }
    }

    fn set(&mut self, index: i32, val: i32) {
        self.arr[index as usize] = val;
        self.snaps[index as usize].push((self.snap_id, val));
    }

    fn snap(&mut self) -> i32 {
        self.snap_id += 1;
        self.snap_id - 1
    }

    fn get(&self, index: i32, snap_id: i32) -> i32 {
        let snaps = &self.snaps[index as usize];
        let mut left = 0;
        let mut right = snaps.len() - 1;
        let mut res = 0;

        while left <= right {
            let mid = left + (right - left) / 2;
            if snaps[mid].0 <= snap_id {
                res = snaps[mid].1;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        res
    }
}