var calculateScore = function(s, k) {
    let n = s.length;
    let score = 0;
    let visited = new Array(n).fill(false);

    for (let i = 0; i < k.length; i++) {
        let index = k[i];
        if (!visited[index]) {
            visited[index] = true;
            score++;

            let left = index - 1;
            while (left >= 0 && s[left] === s[index] && !visited[left]) {
                visited[left] = true;
                score++;
                left--;
            }

            let right = index + 1;
            while (right < n && s[right] === s[index] && !visited[right]) {
                visited[right] = true;
                score++;
                right++;
            }
        }
    }

    return score;
};