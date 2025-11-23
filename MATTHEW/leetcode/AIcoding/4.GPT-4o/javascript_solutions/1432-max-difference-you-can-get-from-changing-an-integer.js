function maximumDifference(num) {
    const strNum = num.toString();
    let maxNum = Number(strNum.replace(Math.min(...strNum), '9'));
    let minNum = Number(strNum.replace(Math.max(...strNum), '0'));
    return maxNum - minNum;
}