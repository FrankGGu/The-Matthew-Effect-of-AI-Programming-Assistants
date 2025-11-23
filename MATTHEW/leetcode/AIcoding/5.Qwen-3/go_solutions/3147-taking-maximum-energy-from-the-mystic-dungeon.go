package main

func maxEnergy(energy []int, k int) int {
    n := len(energy)
    for i := n - 1; i >= 0; i-- {
        if i+k < n {
            energy[i] += energy[i+k]
        }
    }
    return energy[0]
}