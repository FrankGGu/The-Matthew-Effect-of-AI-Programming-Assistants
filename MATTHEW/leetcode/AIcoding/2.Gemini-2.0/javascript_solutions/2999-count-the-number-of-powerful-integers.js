var countPowerfulIntegers = function(start, finish, limit, s) {
    const sLen = s.length;
    const finishStr = finish.toString();
    const finishLen = finishStr.length;
    const startStr = start.toString();
    const startLen = startStr.length;

    function count(num) {
        const numStr = num.toString();
        const numLen = numStr.length;
        let res = 0;

        for (let len = sLen; len <= numLen; len++) {
            if (len > sLen && len < numLen) {
                res += Math.pow(10, len - sLen - 1) * 9;
            } else if (len === sLen) {
                if (parseInt(s) <= num) {
                    res++;
                }
            } else {
                const prefixLen = len - sLen;
                const prefixMax = parseInt(numStr.substring(0, prefixLen));

                if (prefixLen > 0) {
                    res += (prefixMax - (prefixLen > 1 ? Math.pow(10,prefixLen -1) : 0)) * Math.pow(10, 0);
                }

                const combined = parseInt(numStr.substring(0, prefixLen) + s);
                if (combined <= num) {
                    res++;
                }
            }
        }
        return res;
    }

    let result = 0;
    for(let len = s.length; len <= finishStr.length; len++){
        const minPrefixLen = Math.max(0, len - s.length);
        const maxPrefixLen = len - s.length;
        let minVal = Math.pow(10, minPrefixLen - (minPrefixLen > 0 ? 0 : 1));
        if(minPrefixLen === 0){
            minVal = parseInt(s);
        }else{
            minVal = minVal * Math.pow(10,0);
        }
        let maxVal = Math.pow(10, maxPrefixLen) -1;
        if(maxPrefixLen === 0){
            maxVal = parseInt(s);
        }else{
             maxVal = maxVal * Math.pow(10,0);
        }

        let startPrefix = Math.pow(10, len - s.length -1 );

        if(len === s.length){
            startPrefix = 0;
        }

        const pow = Math.pow(10, len - s.length) * parseInt(s);

        let startNum = start;
        let finishNum = finish;

        let minCandidate = -1;
        if(len > s.length){
            minCandidate = Math.pow(10, len - s.length -1);
            let temp = parseInt(Math.pow(10, len - s.length -1) + s);
        }else{
            minCandidate = parseInt(s);
        }

        let maxCandidate = -1;
        if(len > s.length){
            maxCandidate = Math.pow(10, len - s.length)-1;
            let temp = parseInt(Math.pow(10, len - s.length -1) + s);
        }else{
            maxCandidate = parseInt(s);
        }
    }

    function helper(num){
        let count = 0;
        let numStr = num.toString();

        for(let len = sLen; len <= numStr.length; len++){
            if(len > sLen && len < numStr.length){
                count += Math.pow(10, len - sLen -1) * 9
            }else if(len === sLen){
                const currentNum = parseInt(s);
                if(currentNum <= num){
                    count++
                }
            }else{
                const numPrefixLen = len - sLen;
                const prefixMax = parseInt(numStr.substring(0, numPrefixLen));

                if(numPrefixLen > 0){
                    count += (prefixMax - (numPrefixLen > 1? Math.pow(10, numPrefixLen -1) : 0)) * Math.pow(10,0);
                }

                const combined = parseInt(numStr.substring(0, numPrefixLen) + s);
                if(combined <= num){
                    count++
                }
            }
        }

        return count;
    }

    return helper(finish) - helper(start - 1);
};