function alphabetBoardPath(target) {
    let res = [];
    let x = 0, y = 0;
    for (let c of target) {
        let idx = c.charCodeAt(0) - 'a'.charCodeAt(0);
        let nx = idx % 6;
        let ny = Math.floor(idx / 6);
        while (y > ny) { res.push('U'), y--; }
        while (x < nx) { res.push('R'), x++; }
        while (x > nx) { res.push('L'), x--; }
        while (y < ny) { res.push('D'), y++; }
        res.push('!');
    }
    return res.join('');
}