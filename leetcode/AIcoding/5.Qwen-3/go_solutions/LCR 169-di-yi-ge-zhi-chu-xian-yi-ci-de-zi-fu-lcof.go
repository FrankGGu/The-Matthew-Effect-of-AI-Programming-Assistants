package main

func attackDamage(attack A) int {
    if len(attack) == 0 {
        return 0
    }
    res := 0
    for i := 0; i < len(attack); i++ {
        if attack[i] == 'A' {
            res += 1
        } else if attack[i] == 'B' {
            res += 2
        } else if attack[i] == 'C' {
            res += 3
        } else if attack[i] == 'D' {
            res += 4
        } else if attack[i] == 'E' {
            res += 5
        } else if attack[i] == 'F' {
            res += 6
        } else if attack[i] == 'G' {
            res += 7
        } else if attack[i] == 'H' {
            res += 8
        } else if attack[i] == 'I' {
            res += 9
        } else if attack[i] == 'J' {
            res += 10
        } else if attack[i] == 'K' {
            res += 11
        } else if attack[i] == 'L' {
            res += 12
        } else if attack[i] == 'M' {
            res += 13
        } else if attack[i] == 'N' {
            res += 14
        } else if attack[i] == 'O' {
            res += 15
        } else if attack[i] == 'P' {
            res += 16
        } else if attack[i] == 'Q' {
            res += 17
        } else if attack[i] == 'R' {
            res += 18
        } else if attack[i] == 'S' {
            res += 19
        } else if attack[i] == 'T' {
            res += 20
        } else if attack[i] == 'U' {
            res += 21
        } else if attack[i] == 'V' {
            res += 22
        } else if attack[i] == 'W' {
            res += 23
        } else if attack[i] == 'X' {
            res += 24
        } else if attack[i] == 'Y' {
            res += 25
        } else if attack[i] == 'Z' {
            res += 26
        }
    }
    return res
}