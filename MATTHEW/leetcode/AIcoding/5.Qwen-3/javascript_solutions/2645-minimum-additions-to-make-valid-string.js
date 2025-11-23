function minAdditions(s) {
    let res = 0;
    let open = 0;
    for (let c of s) {
        if (c === '(') {
            open++;
        } else {
            if (open > 0) {
                open--;
            } else {
                res++;
            }
        }
    }
    return res + open;
}