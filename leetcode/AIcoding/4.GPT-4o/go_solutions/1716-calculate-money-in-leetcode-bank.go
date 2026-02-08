func totalMoney(n int) int {
    weeks := n / 7
    days := n % 7
    return weeks*(28+7*weeks)/2 + (days*(days+1))/2 + weeks*days
}