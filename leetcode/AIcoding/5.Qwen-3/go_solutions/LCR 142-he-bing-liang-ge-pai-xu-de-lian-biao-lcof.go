package main

func trainingPlan(gym: [Int], k: Int) -> Int {
    var count = 0
    for i in 0..<gym.count {
        if gym[i] % k == 0 {
            count += 1
        }
    }
    return count
}