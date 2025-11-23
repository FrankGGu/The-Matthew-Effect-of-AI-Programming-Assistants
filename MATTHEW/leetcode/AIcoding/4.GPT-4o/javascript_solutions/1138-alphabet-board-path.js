function alphabetBoardPath(target) {
    const path = [];
    let x = 0, y = 0;

    for (const char of target) {
        const newX = Math.floor((char.charCodeAt(0) - 97) / 5);
        const newY = (char.charCodeAt(0) - 97) % 5;

        while (x > newX) {
            path.push('U');
            x--;
        }
        while (y > newY) {
            path.push('L');
            y--;
        }
        while (x < newX) {
            path.push('D');
            x++;
        }
        while (y < newY) {
            path.push('R');
            y++;
        }

        path.push('!');
    }

    return path.join('');
}