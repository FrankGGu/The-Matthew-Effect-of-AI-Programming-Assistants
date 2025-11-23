function breakingPoints(password) {
    let count = 0;
    for (let i = 0; i < password.length; i++) {
        if (password[i] === '0') {
            count++;
        }
    }
    return count;
}