var countVisitedNodes = function(edges) {
    const n = edges.length;
    const ans = new Array(n).fill(0);
    const visited = new Array(n).fill(false);

    for (let i = 0; i < n; i++) {
        if (ans[i] === 0) {
            const path = [];
            let curr = i;
            while (!visited[curr]) {
                visited[curr] = true;
                path.push(curr);
                curr = edges[curr];
            }

            let cycleIndex = -1;
            for (let j = 0; j < path.length; j++) {
                if (path[j] === curr) {
                    cycleIndex = j;
                    break;
                }
            }

            if (cycleIndex !== -1) {
                const cycleLength = path.length - cycleIndex;
                for (let j = cycleIndex; j < path.length; j++) {
                    ans[path[j]] = cycleLength;
                }

                for (let j = cycleIndex - 1; j >= 0; j--) {
                    let nextNode = edges[path[j]];
                    let count = 1;
                    let temp = path[j];
                    while(ans[temp] === 0){
                        ans[temp] = count + ans[nextNode];
                        temp = path[path.indexOf(temp)-1];
                        count++;
                    }
                }
            } else {
                let count = 1;
                for (let j = path.length - 1; j >= 0; j--) {
                    let nextNode = edges[path[j]];
                   let temp = path[j];

                    while(ans[temp] === 0){
                        ans[temp] = count + ans[nextNode];
                        if(path.indexOf(temp) > 0){
                            temp = path[path.indexOf(temp)-1];
                            count++;
                        } else {
                            break;
                        }

                    }
                }
            }

            for(let j = 0; j < n; j++){
                visited[j] = false;
            }
        }
    }

    return ans;
};