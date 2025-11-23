type AuthenticationManager struct {
    ttl int
    tokens map[string]int
}

func Constructor(timeToLive int) AuthenticationManager {
    return AuthenticationManager{
        ttl: timeToLive,
        tokens: make(map[string]int),
    }
}

func (this *AuthenticationManager) Generate(tokenId string, currentTime int)  {
    this.tokens[tokenId] = currentTime + this.ttl
}

func (this *AuthenticationManager) Renew(tokenId string, currentTime int)  {
    if expiry, ok := this.tokens[tokenId]; ok && expiry > currentTime {
        this.tokens[tokenId] = currentTime + this.ttl
    }
}

func (this *AuthenticationManager) CountUnexpiredTokens(currentTime int) int {
    count := 0
    for _, expiry := range this.tokens {
        if expiry > currentTime {
            count++
        }
    }
    return count
}