func largestGoodInteger(num string) string {
    maxGood := "" 

    for i := 0; i <= len(num)-3; i++ {
        if num[i] == num[i+1] && num[i+1] == num[i+2] {
            currentGood := num[i : i+3]

            if maxGood == "" || currentGood > maxGood {
                maxGood = currentGood
            }
        }
    }

    return maxGood
}