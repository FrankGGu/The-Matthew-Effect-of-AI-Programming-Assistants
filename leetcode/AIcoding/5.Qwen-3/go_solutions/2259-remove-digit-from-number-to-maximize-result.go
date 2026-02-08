package main

func removeDigit(number string, digit byte) string {
    var index int = -1
    for i := 0; i < len(number); i++ {
        if number[i] == digit {
            index = i
            if i+1 < len(number) && number[i+1] > number[i] {
                break
            }
        }
    }
    return number[:index] + number[index+1:]
}