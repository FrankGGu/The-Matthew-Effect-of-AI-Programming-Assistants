var isPossible = function(nums, adj) {
    const n = nums.length;
    const groups = new Set(nums);
    if (groups.size > 4) return false;
    if (groups.size <= 2) return true;

    const groupMap = new Map();
    for (let i = 0; i < n; i++) {
        if (!groupMap.has(nums[i])) {
            groupMap.set(nums[i], []);
        }
        groupMap.get(nums[i]).push(i);
    }

    if (groups.size === 3) {
        for (let i = 0; i < adj.length; i++) {
            const [u, v] = adj[i];
            const groupU = nums[u];
            const groupV = nums[v];
            if (groupU !== groupV) return true;
        }
        return false;
    }

    if (groups.size === 4) {
        const groupsArray = Array.from(groups);
        for (let i = 0; i < 4; i++) {
            for (let j = i + 1; j < 4; j++) {
                let found = false;
                const uIndices = groupMap.get(groupsArray[i]);
                const vIndices = groupMap.get(groupsArray[j]);

                for(const uIndex of uIndices){
                    for(const vIndex of vIndices){
                        let connected = false;
                         for (let k = 0; k < adj.length; k++) {
                            const [adjU, adjV] = adj[k];
                            if ((adjU === uIndex && adjV === vIndex) || (adjU === vIndex && adjV === uIndex)) {
                                connected = true;
                                break;
                            }
                        }
                        if(!connected){
                            found = true;
                            break;
                        }
                    }
                    if(found) break;
                }

                if (found) {
                    let found2 = false;
                     for (let k = j + 1; k < 4; k++){
                        let found3 = false;
                        const xIndices = groupMap.get(groupsArray[k]);
                        const otherIndices = groupMap.get(groupsArray[6 - i - j -k]);

                        for(const xIndex of xIndices){
                            for(const otherIndex of otherIndices){
                                let connected = false;
                                for (let l = 0; l < adj.length; l++) {
                                    const [adjU, adjV] = adj[l];
                                    if ((adjU === xIndex && adjV === otherIndex) || (adjU === otherIndex && adjV === xIndex)) {
                                        connected = true;
                                        break;
                                    }
                                }
                                if(!connected){
                                    found3 = true;
                                    break;
                                }
                            }
                            if(found3) break;
                        }
                        if(found3){
                           found2 = true;
                           break;
                        }
                    }
                     if(found2) return true;
                }
            }
        }
        return false;
    }
};