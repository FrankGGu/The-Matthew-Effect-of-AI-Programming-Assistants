package main

func minTotalTime(shoping: [Int], customers: [Int]) -> Int {
    var i = 0
    var j = 0
    var total := 0
    for i < shoping.count && j < customers.count {
        if shoping[i] <= customers[j] {
            total += shoping[i]
            i += 1
        } else {
            total += customers[j]
            j += 1
        }
    }
    for i < shoping.count {
        total += shoping[i]
        i += 1
    }
    for j < customers.count {
        total += customers[j]
        j += 1
    }
    return total
}