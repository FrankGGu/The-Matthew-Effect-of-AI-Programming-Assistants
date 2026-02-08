use std::collections::BTreeMap;

pub struct KthNearestObstacle {
    obstacles: BTreeMap<(i32, i32), i32>,
}

impl KthNearestObstacle {
    pub fn new(obstacles: Vec<Vec<i32>>) -> Self {
        let mut obstacle_map = BTreeMap::new();
        for (i, obstacle) in obstacles.iter().enumerate() {
            obstacle_map.insert((obstacle[0], obstacle[1]), i as i32);
        }
        KthNearestObstacle { obstacles: obstacle_map }
    }

    pub fn query(&self, x: i32, y: i32, k: i32) -> i32 {
        let mut distances = Vec::new();
        for (&(ox, oy), &index) in &self.obstacles {
            let dist = (ox - x).pow(2) + (oy - y).pow(2);
            distances.push((dist, index));
        }
        distances.sort_unstable();
        if k as usize <= distances.len() {
            distances[k as usize - 1].1
        } else {
            -1
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_kth_nearest_obstacle() {
        let obstacles = vec![vec![1, 2], vec![2, 3], vec![3, 4]];
        let kno = KthNearestObstacle::new(obstacles);
        assert_eq!(kno.query(1, 1, 1), 0);
        assert_eq!(kno.query(1, 1, 2), 1);
        assert_eq!(kno.query(1, 1, 3), 2);
        assert_eq!(kno.query(1, 1, 4), -1);
    }
}