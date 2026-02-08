var intersectionSizeTwo = function(intervals) {
    intervals.sort((a, b) => a[1] - b[1] || b[0] - a[0]);

    let ans = 0;
    let p1 = -1; 
    let p2 = -1; 

    for (const [start, end] of intervals) {
        if (start > p1) { 
            ans += 2;
            p1 = end;
            p2 = end - 1;
        } else if (start > p2) { 
            ans += 1;
            p2 = p1; 
            p1 = end; 
        }
    }

    return ans;
};